table 50480 "Enquiries Lines"
{
    fields
    {
        field(1; "Serial No."; Code[10])
        {
            NotBlank = true;
        }
        field(2; "Line no"; Integer)
        {
            AutoIncrement = true;
            NotBlank = true;
        }
        field(3; Remarks; Text[250])
        {
        }
        field(4; User; Code[50])
        {
        }
        field(5; "Action"; Text[30])
        {
        }
    }
    keys
    {
        key(Key1; "Serial No.", "Line no")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        User:=UserId;
    end;
    trigger OnModify()
    begin
        User:=UserId;
    end;
    var UserSetup: Record "User Setup";
}
