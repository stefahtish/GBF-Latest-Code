table 50230 "Base Calender Custom"
{
    LookupPageID = "Base Calender List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Customized Changes Exist"; Boolean)
        {
            CalcFormula = Exist("Customized Calendar Change" WHERE("Base Calendar Code"=FIELD(Code)));
            Caption = 'Customized Changes Exist';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var CustCalendarChange: Record "Customized Calendar Change";
    BaseCalendarLine: Record "Base Calendar Change";
    Text001: Label 'You cannot delete this record. Customized calendar changes exist for calendar code=<%1>.';
}
