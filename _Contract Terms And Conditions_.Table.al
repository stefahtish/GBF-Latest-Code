table 50698 "Contract Terms And Conditions"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; integer)
        {
            DataClassification = ToBeClassified;
            autoincrement = true;
        }
        field(2; "Terms and Condition"; code[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Terms & Condition Description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Terms and Condition", "Terms & Condition Description")
        {
        }
    }
    var myInt: Integer;
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
