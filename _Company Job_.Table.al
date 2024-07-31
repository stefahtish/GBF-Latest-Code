table 50306 "Company Job"
{
    DrillDownPageID = "Company Job List";
    LookupPageID = "Company Job List";

    fields
    {
        field(1; "Job ID"; Code[80])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Job Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "No of Posts"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields("Occupied Position");
                //IF "No of Posts" <> xRec."No of Posts" THEN
                Vacancy:="No of Posts" - "Occupied Position";
            end;
        }
        field(4; "Position Reporting to"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job"."Job ID";

            trigger OnValidate()
            begin
                if "Position Reporting to" = "Job ID" then begin
                    Error(Text001);
                end
                else
                begin
                    if "Position Reporting to" <> '' then begin
                        JSupervised.Reset;
                        JSupervised.SetRange("Job ID", "Position Reporting to");
                        JSupervised.SetRange("Position Supervised", "Job ID");
                        if not JSupervised.Find('-')then begin
                            JSupervised.Init;
                            JSupervised."Job ID":="Position Reporting to";
                            JSupervised."Position Supervised":="Job ID";
                            JSupervised.Validate("Position Supervised");
                            if not JSupervised.Get(JSupervised."Job ID", JSupervised."Position Supervised")then JSupervised.Insert;
                        end;
                    end;
                end;
            end;
        }
        field(5; "Occupied Position"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Job Position"=FIELD("Job ID")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                Vacancy:="No of Posts" - "Occupied Position";
            end;
        }
        field(6; "Vacant Positions"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Score code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(9; "Dimension 2"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(Code, "Dimension 2");
                if DimVal.Find('-')then "Department Name":=DimVal.Name;
            end;
        }
        field(10; "Dimension 3"; Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(11; "Dimension 4"; Code[20])
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));
        }
        field(12; "Dimension 5"; Code[20])
        {
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(5));
        }
        field(13; "Dimension 6"; Code[20])
        {
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(6));
        }
        field(14; "Dimension 7"; Code[20])
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(7));
        }
        field(15; "Dimension 8"; Code[20])
        {
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(8));
        }
        field(16; "No of Position"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Vacancy:="No of Posts" - "Occupied Position";
            end;
        }
        field(17; "Total Score"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(18; "Stage filter"; Integer)
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value";
        }
        field(19; Objective; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Key Position"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Category; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Grade; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale".Scale;
        }
        field(24; "Primary Skills Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Auditors,Consultants,Training,Certification,Administration,Marketing,Management,Business Development,Other';
            OptionMembers = Auditors, Consultants, Training, Certification, Administration, Marketing, Management, "Business Development", Other;
        }
        field(25; "2nd Skills Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Auditors,Consultants,Training,Certification,Administration,Marketing,Management,Business Development,Other';
            OptionMembers = Auditors, Consultants, Training, Certification, Administration, Marketing, Management, "Business Development", Other;
        }
        field(26; "3nd Skills Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Auditors,Consultants,Training,Certification,Administration,Marketing,Management,Business Development,Other';
            OptionMembers = Auditors, Consultants, Training, Certification, Administration, Marketing, Management, "Business Development", Other;
        }
        field(27; Management; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Vacancy; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Department Name"; Text[100])
        {
            FieldClass = Normal;
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
    }
    keys
    {
        key(Key1; "Job ID")
        {
            Clustered = true;
        }
        key(Key2; "Vacant Positions")
        {
        }
        key(Key3; "Dimension 1")
        {
        }
        key(Key4; "Dimension 2")
        {
        }
        key(Key5; "Total Score")
        {
            Enabled = false;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Job ID", "Job Description")
        {
        }
    }
    var JSupervised: Record "Positions Supervised";
    DimVal: Record "Dimension Value";
    Text001: Label 'The Job cannot be supervised by this Position';
}
