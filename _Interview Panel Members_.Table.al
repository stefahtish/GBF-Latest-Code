table 50251 "Interview Panel Members"
{
    LookupPageID = "Interview Panel Members";

    fields
    {
        field(2; "Panel Member Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST(Internal))Employee;

            trigger OnValidate()
            var
                EmployeeRec: Record Employee;
            begin
                if EmployeeRec.get("Panel Member Code")then "Panel Member Name":=EmployeeRec.FullName();
            end;
        }
        field(3; "Panel Member Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ", Internal, External;
        }
        field(5; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }
    keys
    {
        key(Key1; "Line No.", "Panel Member Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
