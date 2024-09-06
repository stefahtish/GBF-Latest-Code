tableextension 50172 "Approval Comment Ext" extends "Approval Comment Line"
{
    fields
    {
        modify("User ID")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                InsertName("User ID");
            end;
        }
        field(50000; Designation; Text[100])
        {
            Caption = 'Designation';
            DataClassification = ToBeClassified;
        }
        field(50001; Name; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(50002; "Approval Status"; enum "Approval Status-custom")
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    var
    begin
        InsertName(UserId);
    end;

    procedure InsertName(UserID: code[50])
    var
        UserSetup: record "User Setup";
        Employee: Record Employee;
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserID);
        if UserSetup.FindFirst() then begin
            Employee.reset;
            Employee.SetRange("No.", UserSetup."Employee No.");
            if Employee.FindFirst() then begin
                Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                Designation := Employee."Job Title2";
            end;
        end;
    end;
}
