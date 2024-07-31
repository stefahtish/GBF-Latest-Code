table 50744 "Applicant job applied"
{
    Caption = 'Applicant job applied';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Need Code"; Code[20])
        {
            Caption = 'Need Code';
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Needs"."No." WHERE(Status=CONST(Released), "Shortlisting Started"=const(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Needs: Record "Recruitment Needs";
            begin
                Needs.Reset;
                Needs.SetRange(Needs."No.", "Need Code");
                if Needs.Find('-')then "Job":=Needs.Description;
            end;
        }
        field(2; Job; Text[100])
        {
            Caption = 'Job';
            DataClassification = ToBeClassified;
        }
        field(3; "Application No."; Code[20])
        {
            Caption = 'Applicant No.';
            DataClassification = ToBeClassified;
            TableRelation = Applicants2;

            trigger OnValidate()
            var
                Applicants2: Record Applicants2;
            begin
                Applicants2.SetRange("No.", "Application No.");
                if Applicants2.FindFirst()then begin
                    Email:=Applicants2."E-Mail";
                    Name:=Applicants2."First Name" + '' + Applicants2."Middle Name" + '' + Applicants2."Last Name";
                    "First Name":=Applicants2."First Name";
                    "Middle Name":=Applicants2."Middle Name";
                    "Last Name":=Applicants2."Last Name";
                end;
            end;
        }
        field(4; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Name; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "No. series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Minimum Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Maximum Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Status;enum "Job Applicant Status")
        {
            DataClassification = ToBeClassified;
        }
        field(15; Shortlist; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Qualified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; Oral; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Oral (Board)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Practical; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Classroom; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Practical Score"; Decimal)
        {
        // CalcFormula = Average("Practical Interview".Score WHERE("Applicant No" = FIELD("No.")));
        // FieldClass = FlowField;
        }
        field(22; "Classroom Score"; Decimal)
        {
        // CalcFormula = Average("Classroom Interview".Score WHERE("Applicant No" = FIELD("No.")));
        // FieldClass = FlowField;
        }
        field(23; "Oral Score"; Decimal)
        {
        // CalcFormula = Average("Oral Interview".Score WHERE("Applicant No" = FIELD("No.")));
        // FieldClass = FlowField;
        }
        field(24; "Oral (Board) Score"; Decimal)
        {
        // CalcFormula = Average("Oral Interview (Board)".Score WHERE("Applicant No" = FIELD("No.")));
        // FieldClass = FlowField;
        }
        field(25; "Expected Reporting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Interviewed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Interview Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Interview Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "First Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; Resume; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(33; Motivation; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(34; "Outcome of Sifting";enum "Outcome of Sifting")
        {
            DataClassification = ToBeClassified;
        }
        field(35; Reason; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(36; Observation; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Enigma Score"; Decimal)
        {
            caption = 'Psychometric Assessment';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Need Code", "Application No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Applicants Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Applicants Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            "Application Date":=Today;
        end;
    end;
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
