int main (string[] args) {
    print ("A new Vala app\n");
    const string SOURCE_FILENAME = "initial.vala";

    Vala.CodeContext context = new Vala.CodeContext ();
    Vala.CodeContext.push (context);
    context.add_source_filename (SOURCE_FILENAME);
    // Vala.Parser parser = new Vala.Parser ();

    return 0;
}
