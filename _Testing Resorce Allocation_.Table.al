table 50565 "Testing Resorce Allocation"
{
    Caption = 'Testing Resource Allocation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; AllocationNo; Code[20])
        {
            Caption = 'AllocationNo';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF AllocationNo <> '' THEN NoSeriesMgt.TestManual(LabSetup."Testing schedule Nos");
            end;
        }
        field(2; TestingScheduleNo; Code[20])
        {
            Caption = 'TestingScheduleNo';
            DataClassification = ToBeClassified;
            TableRelation = "Lab Annual Testing Schedule";
        }
        field(3; "Nature of testing"; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Nature of Testing"));
        }
        field(4; Branch; Code[20])
        {
            Caption = 'Branch';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(5; County; Code[20])
        {
            Caption = 'County';
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
        field(6; Market; Code[20])
        {
            Caption = 'Market';
            DataClassification = ToBeClassified;
        }
        field(7; Location; Code[20])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
            TableRelation = Locations."Location Code";
        }
        field(8; "Testing date"; Date)
        {
            Caption = 'Testing date';
            DataClassification = ToBeClassified;
        }
        field(9; Vehicle; Code[50])
        {
            Caption = 'Vehicle';
            DataClassification = ToBeClassified;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Allocated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Annual Schedule"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Lab Annual Testing Schedule" where("Resource Allocated"=const(false), Scheduled=const(true));

            trigger OnValidate()
            var
                Schedule: Record "Lab Annual Testing Schedule";
                ScheduleLines: Record "Resource Allocation Line";
                TestingLines: Record "Resource Allocation Line";
            begin
                Schedule.SetRange(Code, "Annual Schedule");
                if Schedule.Find('-')then begin
                    "Cluster Option":=Schedule."Cluster Option";
                    Branch:=Schedule.Branch;
                    Cluster:=Schedule.Cluster;
                    County:=Schedule.County;
                    "County Name":=Schedule."County Name";
                    Location:=Schedule.Location;
                    Market:=Schedule.Market;
                    "Nature of testing":=Schedule."Nature of Testing";
                    "Testing date":=Schedule."Proposed Start Date";
                    ScheduleLines.Reset();
                    ScheduleLines.SetRange(AllocationNo, Schedule.Code);
                    if ScheduleLines.Find('-')then begin
                        repeat TestingLines.Init();
                            TestingLines.AllocationNo:=AllocationNo;
                            TestingLines.Category:=ScheduleLines.Category;
                            TestingLines."No.":=ScheduleLines."No.";
                            TestingLines.Quantity:=ScheduleLines.Quantity;
                            TestingLines."Unit cost":=ScheduleLines."Unit cost";
                            TestingLines.Amount:=ScheduleLines.Amount;
                            TestingLines.Insert();
                        until ScheduleLines.Next() = 0;
                    end;
                end;
            end;
        }
        field(13; "County Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Cluster; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cluster Regions";
        }
        field(15; "Cluster Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Cluster;
            OptionCaption = ' ,Cluster';
        }
        field(16; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; AllocationNo)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if not LabSetup.Get()then begin
            LabSetup.Init();
            LabSetup.Insert();
        end;
        LabSetup.TESTFIELD("Testing schedule Nos");
        NoSeriesMgt.InitSeries(LabSetup."Testing schedule Nos", xRec."No. Series", TODAY, AllocationNo, "No. Series");
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    LabSetup: Record "Lab Setup";
}
