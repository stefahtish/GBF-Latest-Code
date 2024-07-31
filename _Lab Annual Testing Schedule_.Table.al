table 50562 "Lab Annual Testing Schedule"
{
    fields
    {
        field(1; "Nature of Testing"; Text[500])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Nature of Testing"));
        }
        field(3; "Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period" where(closed=const(false));
        }
        field(4; Code; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Code <> '' THEN NoSeriesMgt.TestManual(LabSetup."Annual schedule Nos");
            end;
        }
        field(5; Branch; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(6; County; Code[20])
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
        field(7; Market; Text[20])
        {
            DataClassification = ToBeClassified;
        //TableRelation = Market;
        }
        field(8; Location; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Locations."Location Code";
        }
        field(9; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Scheduled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Proposed Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Proposed End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Proposed Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Proposed End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Target Client"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "County Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Cluster; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cluster Regions";
        }
        field(22; "Cluster Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Cluster;
            OptionCaption = ' ,Cluster';
        }
        field(23; "Resource Allocated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Tested; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Target No of Clients"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Archive; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open, "Pending Approval", Released, Rejected;
        }
        field(28; Frequency; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Weekly,Monthly,Quarterly,Semi-Annualy';
            OptionMembers = Weekly, Monthly, Quarterly, SemiAnnualy;
        }
        field(29; "Next Notification Date"; Date)
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
    trigger OnInsert()
    begin
        if not LabSetup.Get()then begin
            LabSetup.Init();
            LabSetup.Insert();
        end;
        LabSetup.TESTFIELD("Annual schedule Nos");
        NoSeriesMgt.InitSeries(LabSetup."Annual schedule Nos", xRec."No. Series", TODAY, Code, "No. Series");
    end;
    var LabSetup: Record "Lab Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
