table 50210 "Employee Disciplinary Cases"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Refference No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Disciplinary Case"; Code[20])
        {
            Caption = 'Type of Hearing';
            DataClassification = ToBeClassified;
            TableRelation = "Disciplinary Cases".Code;

            trigger OnValidate()
            begin
                Cases.Reset;
                Cases.SetRange(Code, "Disciplinary Case");
                if Cases.Find('-')then begin
                    "Case Description":=Cases.Description;
                    "Recommended Action":=Cases."Action Description";
                end;
            end;
        }
        field(5; "Recommended Action"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recommended Actions";
        }
        field(6; "Case Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Accused Defence"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Witness #1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange("No.", "Witness #1");
                if Employee.Find('-')then begin
                    "Witness Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(9; "Witness #2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Action Taken"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Disciplinary Actions".Code;

            trigger OnValidate()
            begin
                Actions.Reset;
                Actions.SetRange(Code, "Action Taken");
                if Actions.Find('-')then begin
                    "Action Description":=Actions.Description;
                end;
            end;
        }
        field(11; "Date Taken"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Attachment; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Disciplinary Remarks"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Cases Discusion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Language Code (Default)"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "RecAction Description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Other Incident"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Incident Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Incident Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Incident ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Action Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Witness Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Staff,Others';
            OptionMembers = " ", Staff, Others;
        }
        field(26; "Witness Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Hearing"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Capability"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(29; Defense; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Refference No", "Employee No", "Disciplinary Case")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Cases: Record "Disciplinary Cases";
    "Actions": Record "Disciplinary Actions";
    Employee: Record Employee;
}
