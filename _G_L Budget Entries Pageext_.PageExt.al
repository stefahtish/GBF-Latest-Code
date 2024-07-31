pageextension 50149 "G/L Budget Entries Pageext" extends "G/L Budget Entries"
{
    trigger OnAfterGetCurrRecord()
    var
        GLSetup: Record "General Ledger Setup";
    begin
    // GLSetup.Get();
    // GLSetup.TestField("Current Budget");
    // if "Budget Name" = GLSetup."Current Budget" then
    //     CurrYear := true
    // else
    //     CurrYear := false;
    // Commit();
    // Error(GLSetup."Current Budget");
    end;
}
