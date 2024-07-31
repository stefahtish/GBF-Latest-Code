table 50207 "Employee Discplinary"
{
    DrillDownPageId = "Employee Disciplinary List";
    LookupPageId = "Employee Disciplinary List";

    fields
    {
        field(1; "Disciplinary Nos"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Disciplinary Nos" <> xRec."Disciplinary Nos" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Disciplinary Cases Nos.");
                    "No.Series":='';
                end;
            end;
        }
        field(2; "Employee No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange("No.", "Employee No");
                if Employee.Find('-')then begin
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Gender:=Employee.Gender;
                    "Job Title":=Employee."Job Position Title";
                    "Date of Join":=Employee."Date Of Join";
                    "Recipient Email":=Employee."Company E-Mail";
                end;
            end;
        }
        field(3; "Employee Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Gender;Enum "Employee Gender")
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Job Title"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Date of Join"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No.Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "E-Mail Body Text"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "E-Mail Subject"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Attachment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Recipient Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Recipient CC"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Recipient BCC"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Date Closed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Escalate; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Committee E-Mail Body Text"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Committee E-Mail Subject"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Committee Recipient Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Committee Recipient CC"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Select Email Type"; Option)
        {
            OptionMembers = " ", "Individual Email", "Committee Email";
        }
        field(23; "Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Committee Recipient BCC"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Date Escalated"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Committee No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Committee Members Setup";
        }
    }
    keys
    {
        key(Key1; "Disciplinary Nos")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Disciplinary Nos" = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Disciplinary Cases Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Disciplinary Cases Nos.", xRec."No.Series", 0D, "Disciplinary Nos", "No.Series");
        end;
    end;
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Employee: Record Employee;
}
