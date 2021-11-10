const string SOURCE_FILENAME = "initial.vala";

int main (string[] args) {
    string[] default_packages = {"glib-2.0", "gobject-2.0"};

    // If you're feeling confused, check out these resources
    // related to the Vala compiler:
    // Hacker's guide to the Vala compiler: https://wiki.gnome.org/Projects/Vala/Hacking
    // libvala reference: https://gnome.pages.gitlab.gnome.org/vala/docs/vala/index.htm

    Vala.CodeContext context = new Vala.CodeContext ();
    Vala.CodeContext.push (context);
    context.add_source_filename (SOURCE_FILENAME, true, false);

    foreach (string package in default_packages) {
        context.add_external_package (package);
    }

    Vala.Parser parser = new Vala.Parser ();
    parser.parse (context);

    context.check ();

    Vala.TraverseVisitor print_statement_visitor = new Vala.TraverseVisitor ((node) => {
        if (node is Vala.MethodCall) {
            var method_call = (Vala.MethodCall) node;
            var current_filename = method_call.source_reference.file.get_relative_filename ();

            if (current_filename != SOURCE_FILENAME) {
                return Vala.TraverseStatus.CONTINUE;
            }

            var method_call_symbol = method_call.call.symbol_reference;

            if (method_call_symbol.name == null) {
                return Vala.TraverseStatus.CONTINUE;
            }

            if (method_call_symbol.name == "print") {
                print ("Found print method in %s, at (%d, %d)!\n",
                    current_filename,
                    method_call.source_reference.begin.line,
                    method_call.source_reference.begin.column
                );

                return Vala.TraverseStatus.STOP;
            }
        }

        return Vala.TraverseStatus.CONTINUE;
    });

    context.accept (print_statement_visitor);
    return 0;
}
