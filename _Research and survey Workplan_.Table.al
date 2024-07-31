table 50631 "Research and survey Workplan"
{
    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Name of research"; Text[2048])
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
        field(5; "Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Output; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Recommendations; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Conclusion; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(9; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "", Research, Survey;
            OptionCaption = ' ,Research,Survey';
        }
        field(12; Venue; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Actual Venue"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Town; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open, "Pending Approval", Released, Rejected;
        }
        field(17; "Service Provider"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if Vendor.get("Service Provider")then "Service provider Name":=Vendor.Name;
            end;
        }
        field(18; "Service provider Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Country; code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(21; "Country Name"; Text[50])
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
    var ResearchSetup: Record "Research Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        ResearchSetup.Get();
        ResearchSetup.TestField("Research and Survey Nos");
        NoSeriesMgt.InitSeries(ResearchSetup."Research and Survey Nos", xRec."No. Series", TODAY, Code, "No. Series");
    end;
}
