table 50244 "Recruitment Needs"
{
    DrillDownPageID = "Approved Recruitment Requests";
    LookupPageID = "Approved Recruitment Requests";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = false;
        }
        field(2; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = "Company Job"."Job ID";

            trigger OnValidate()
            begin
                Jobs.Reset;
                Jobs.SetRange(Jobs."Job ID", "Job ID");
                if Jobs.Find('-')then Description:=Jobs."Job Description";
            end;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'High,Medium,Low';
            OptionMembers = High, Medium, Low;
        }
        field(5; Positions; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Approved; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Date Approved":=Today;
            end;
        }
        field(7; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Stage; Code[20])
        {
            FieldClass = FlowFilter;

            trigger OnValidate()
            begin
            /*
                RShort.RESET;
                RShort.SETRANGE(RShort."Need Code","Need Code");
                RShort.SETRANGE(RShort."Stage Code",Stage);
                RShort.CALCSUMS(RShort."Desired Score");
                Score:=RShort."Desired Score";
                */
            end;
        }
        field(10; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Stage Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Qualified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "No Filter"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(14; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Documentation Link"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Turn Around Time"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(19; "No. Series"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(20; "Reason for Recruitment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "New Position", "Existing Position";
        }
        field(21; "Appointment Type"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract";

            trigger OnValidate()
            var
                EContract: Record "Employment Contract";
            begin
                if EContract.Get("Appointment Type")then "Appointment Type Description":=EContract.Description;
            end;
        }
        field(22; "Requested By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Expected Reporting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment", Rejected;
        }
        field(25; "Reason for Recruitment(text)"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Employment Done"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Employment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Interview Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Shortlisting Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(92; "Education Type";Enum "Education Types")
        {
            DataClassification = ToBeClassified;
        }
        field(93; "Education Level";Enum "Education Level")
        {
            DataClassification = ToBeClassified;
        }
        field(94; "Proficiency Level";enum "Proficiency Level")
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Field of Study"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Field of Study";
        }
        field(96; "Minimum years of experience"; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(97; "Maximum years of experience"; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(98; "Experience industry"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job Industry";
        }
        field(99; "Professional Course"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Qualification.Code where("Qualification Type"=const(Academic), "Education Level"=const(Professional));
        }
        field(100; "Professional Membership"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Professional Memberships";
        }
        field(101; "Submitted To Portal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Shortlisting Started"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Appointment Type Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(104; Gender;enum "Employee Gender")
        {
            DataClassification = ToBeClassified;
        }
        field(105; "County Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = County_1;

            trigger OnValidate()
            var
                cty: Record County_1;
            begin
            // cty.Reset();
            // cty.SetRange(County, "County Code");
            // if cty.FindFirst() then
            //     County := cty.Description;
            end;
        }
        field(106; County; Text[50])
        {
            DataClassification = ToBeClassified;
        //TableRelation = County;
        }
        field(107; MyField; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(108; "Total Practical Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(109; "Total Written Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Total Oral Score"; Decimal)
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
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Resource Request Nos");
            NoSeriesMgt.InitSeries(HRSetup."Resource Request Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Requested By":=UserId;
    end;
    var Jobs: Record "Company Job";
    DimMgt: Codeunit DimensionManagement;
    HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
