table 50246 "Applicants Qualification"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Applicants2."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Qualification Code"; Code[20])
        {
            Caption = 'Qualification Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Qualification;

            trigger OnValidate()
            begin
                Qualifications.Reset;
                Qualifications.SetRange(Qualifications.Code, "Qualification Code");
                if Qualifications.Find('-')then Qualification:=Qualifications.Description;
                ShortCriteria.Reset;
                ShortCriteria.SetRange("Need Code", "Need Code");
                ShortCriteria.SetRange(Qualification, "Qualification Code");
                if ShortCriteria.Find('-')then begin
                    Score:=ShortCriteria."Desired Score";
                end;
                if ShortCriteria."Desired Score" = Score then Qualified:=true
                else
                    Qualified:=false;
            /*
                ShortCriteriaHead.RESET;
                ShortCriteriaHead.SETRANGE("Recruitment Need",Applicant."Need Code");
                IF ShortCriteriaHead.FINDFIRST THEN
                  BEGIN
                    ShortCriteria.RESET;
                    ShortCriteria.SETRANGE("Need Code",ShortCriteriaHead."Recruitment Need");
                    IF ShortCriteria.FIND('-') THEN
                      BEGIN
                        AppQualification.GET("Need Code");
                        AppQualification.SETRANGE("Need Code",ShortCriteria."Need Code");
                        IF AppQualification."Qualification Code"=ShortCriteria.Qualification THEN
                          BEGIN
                            Score:=ShortCriteria."Desired Score";
                            Qualified:=TRUE
                              END ELSE
                            Qualified:=FALSE;
                      END;
                  END;
                */
            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ", Internal, External, "Previous Position";
        }
        field(7; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(8; Institution_Company; Text[100])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
            DataClassification = ToBeClassified;
        }
        field(10; "Need Code"; Code[50])
        {
            Caption = 'Need Code';
            DataClassification = ToBeClassified;
        }
        field(11; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active, Inactive, Terminated;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name"=CONST("Employee Qualification"), "No."=FIELD("Employee No."), "Table Line No."=FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(50000; "Qualification Type"; Option)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
        field(50001; Qualification; Text[200])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50003; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Grade; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Qualified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; No, "Need Code", "Qualification Code")
        {
            Clustered = true;
        }
        key(Key2; "Qualification Code")
        {
        }
    }
    fieldgroups
    {
    }
    var Qualifications: Record Qualification;
    Applicant: Record Applicants2;
    Position: Code[20];
    JobReq: Record "Job Requirements";
    ShortCriteria: Record "R. Shortlisting Criteria";
    ShortCriteriaHead: Record "R.Shortlisting Header";
    AppQualification: Record "Applicants Qualification";
}
