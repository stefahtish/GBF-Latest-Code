table 50627 "Research Activity Plan"
{
    fields
    {
        field(1; "Export Activity Type";enum "Export promotion Types")
        {
            Caption = 'Activity Plan';
            DataClassification = ToBeClassified;
        }
        field(2; "Description of activity"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Country; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Localctry=const(false))"Country/Region"
            ELSE IF(Localctry=const(true))"Country/Region" where(Local=const(true));
        //"Country/Region";
        }
        field(6; County; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = CountyNew."County Code";

            trigger OnValidate()
            var
                cty: Record CountyNew;
            begin
                cty.SetRange("County Code", County);
                if cty.FindFirst()then "County Name":=cty.County;
            end;
        }
        field(7; Subcounty; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub-County"."Sub-County Code" where("County Code"=field(County));

            trigger OnValidate()
            var
                subc: Record "Sub-County";
            begin
                subc.SetRange("Sub-County Code", Subcounty);
                if subc.find('-')then "Sub-County Name":=subc.Name;
            end;
        }
        field(8; Venue; Text[50])
        {
            Caption = 'Planned Venue';
            DataClassification = ToBeClassified;
        }
        field(9; Code; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Research type" = "Research type"::Support then begin
                    if Code <> xRec.Code then NoSeriesMgt.TestManual(ResearchSetup."Stakeholder support plan No.");
                end;
                if "Research type" = "Research type"::Export then begin
                    if Code <> xRec.Code then NoSeriesMgt.TestManual(ResearchSetup."Export promotion workplan Nos");
                end;
                if "Research type" = "Research type"::Dairystds then begin
                    if Code <> xRec.Code then NoSeriesMgt.TestManual(ResearchSetup."Dairy stds plan No.");
                end;
            end;
        }
        field(10; "Support Activity Type";enum "Stakeholder support Types")
        {
            Caption = 'Activity Type';
            DataClassification = ToBeClassified;
        }
        field(11; "Research type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Support, Export, Dairystds;
            OptionCaption = 'Support, Export, Dairy Standards';
        }
        field(12; "Type of participants"; Text[50])
        {
            Caption = 'Key target participants';
            DataClassification = ToBeClassified;
            TableRelation = "Type of Participants";

            trigger OnValidate()
            var
                Types: Record "Type of Participants";
            begin
                "Type of participants":=UpperCase(CopyStr("Type of participants", 1, 1)) + LowerCase(CopyStr("Type of participants", 2))end;
        }
        field(13; "Target Number of participants"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Conclusion; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(16; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(17; Local; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Country/Region".Local where(Code=field(Country)));
        }
        field(19; "Actual Number of participants"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Actual Venue"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Town; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; Localctry; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open, "Pending Approval", Released, Rejected;
        }
        field(24; "Country Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "County Name"; Text[100])
        {
            Caption = 'County Name';
            DataClassification = ToBeClassified;
        }
        field(26; "Sub-County Name"; Text[100])
        {
            Caption = 'SubCounty Name';
            DataClassification = ToBeClassified;
        }
        field(27; "Category"; Text[50])
        {
            Caption = 'Category';
            DataClassification = ToBeClassified;
            TableRelation = "Type of Participants" where(Type=const(ActivityCategory));

            trigger OnValidate()
            var
                Categories: Record "Type of Participants";
            begin
                Categories.SetRange(Code, Category);
                if Categories.FindFirst()then begin
                    if Categories.Local = true then Localctry:=true
                    else
                        Localctry:=false;
                end;
            end;
        }
        field(28; "Other types of participants"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code)
        {
            clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, "Description of activity")
        {
        }
    }
    trigger OnInsert()
    begin
        ResearchSetup.Get;
        case "Research type" of "Research type"::Support: begin
            ResearchSetup.TestField("Stakeholder support plan No.");
            if Code = '' then NoSeriesMgt.InitSeries(ResearchSetup."Stakeholder support plan No.", xRec."No. Series", 0D, Code, "No. Series");
        end;
        "Research type"::Dairystds: begin
            if Code = '' then ResearchSetup.TestField("Dairy stds plan No.");
            NoSeriesMgt.InitSeries(ResearchSetup."Dairy stds plan No.", xRec."No. Series", 0D, Code, "No. Series");
        end;
        "Research type"::Export: begin
            if Code = '' then ResearchSetup.TestField("Export promotion workplan Nos");
            NoSeriesMgt.InitSeries(ResearchSetup."Export promotion workplan Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
        end;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    ResearchSetup: Record "Research Setup";
    local procedure GetNoSeriesCode(): Code[10]begin
        case "Research type" of "Research type"::Dairystds: exit(ResearchSetup."Dairy stds plan No.");
        "Research type"::Export: exit(ResearchSetup."Export promotion workplan Nos");
        "Research type"::Support: exit(ResearchSetup."Stakeholder support plan No.");
        end;
    end;
}
