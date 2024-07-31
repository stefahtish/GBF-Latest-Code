table 50261 "R.Shortlisting Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                IF "No." <> xRec."No." THEN
                  BEGIN
                    HRSetup.GET;
                    NoSeriesMgt.TestManual(HRSetup."ShortList Criteria");
                    "No Series":='';
                  END;
                */
            end;
        }
        field(2; "Recruitment Need"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Needs"."No." WHERE(Status=FILTER(Released));

            trigger OnValidate()
            begin
                RecruitNeed.Reset;
                RecruitNeed.SetRange("No.", "Recruitment Need");
                if RecruitNeed.Find('-')then begin
                    "Job ID":=RecruitNeed."Job ID";
                    Description:=RecruitNeed.Description;
                    Positions:=RecruitNeed.Positions;
                end;
            end;
        }
        field(3; "Job ID"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if CompanyJob.Get("Job ID")then begin
                    "Oral Interview":=CompanyJob."Oral Interview";
                    "Oral Interview (Board)":=CompanyJob."Oral Interview (Board)";
                    Classroom:=CompanyJob.Classroom;
                    Practical:=CompanyJob.Practical;
                end;
            end;
        }
        field(4; Description; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Positions; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Desired Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Desired Interview Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Set';
            OptionMembers = Open, Set;
        }
        field(10; Oral; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Oral (Board)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Practical Interview"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Classroom Interview"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Oral Interview"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Oral Interview (Board)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; Classroom; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; Practical; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Total Desired Score"; Decimal)
        {
            CalcFormula = Sum("R. Shortlisting Criteria"."Desired Score" WHERE("Need Code"=FIELD(UPPERLIMIT("Recruitment Need"))));
            Editable = false;
            FieldClass = FlowField;
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
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Shortlisting Criteria");
            NoSeriesMgt.InitSeries(HRSetup."Shortlisting Criteria", xRec."No Series", 0D, "No.", "No Series");
        end;
    end;
    var RecruitNeed: Record "Recruitment Needs";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    HRSetup: Record "Human Resources Setup";
    CompanyJob: Record "Company Job";
}
