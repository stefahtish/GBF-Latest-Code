table 50628 "Partnerships Activity Plan"
{
    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Code <> Code THEN NoSeriesMgt.TestManual(ResearchSetup."Panership Activities Nos");
            end;
        }
        field(2; "Name of partnership"; Text[2048])
        {
            caption = 'Title of partnersip';
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate(Duration);
            end;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; County; Text[50])
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
        field(7; Subcounty; Text[50])
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
        field(8; Country; code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(9; Venue; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(16; Conclusion; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(17; "More than one country"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Local; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Country/Region".Local where(Code=field(Country)));
        }
        field(19; Duration; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Start Date" <> 0D then "End Date":=CalcDate(Duration, "Start Date");
            end;
        }
        field(20; "Actual Venue"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Town; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open, "Pending Approval", Released, Rejected;
        }
        field(23; "County Name"; Text[50])
        {
            caption = 'County Name';
            DataClassification = ToBeClassified;
        }
        field(24; "Sub-County Name"; Text[50])
        {
            caption = 'SubCounty Name';
            DataClassification = ToBeClassified;
        }
        field(26; "Country Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Budgeted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Partnerships Activity Line"."Budgetary Plan" where("Patnership line type"=filter(Funding), Code=field(Code)));
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
        fieldgroup(DropDown; Code, "Name of partnership")
        {
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        ResearchSetup.Get;
        if Code = '' then begin
            NoSeriesMgt.InitSeries(ResearchSetup."Panership Activities Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    ResearchSetup: Record "Research Setup";
}
