const string DEFAULT_PACKAGE = "glib-2.0";
const string SOURCE_FILENAME = "initial.vala";

int main (string[] args) {
    print ("A new Vala app\n");

    Vala.CodeContext context = new Vala.CodeContext ();
    Vala.CodeContext.push (context);
    context.add_source_filename (SOURCE_FILENAME);
    // context.profile = Vala.Profile.GOBJECT;
    context.add_external_package (DEFAULT_PACKAGE);

    Vala.Parser parser = new Vala.Parser ();
    parser.parse (context);

    context.check ();

    return 0;
}
