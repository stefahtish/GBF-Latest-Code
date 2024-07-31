table 50314 "Strategic Imp Activities"
{
    Caption = 'Strategic Implementation Activities';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Activity Code"; Code[20])
        {
            Caption = '#';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate(InitiativeCode);
            end;
        }
        field(2; Activities; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(3; InitiativeCode; Code[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Imp Initiatives"."SNo.";

            trigger OnValidate()
            var
                StratInit: Record "Strategic Imp Initiatives";
            begin
                if StratInit.Get(StratInit."SNo.", InitiativeCode)then Initiative:=StratInit.Initiatives;
            end;
        }
        field(4; Initiative; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Frequency; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Imp Frequency";
        }
        field(6; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Measure; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; KPI; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Priority; Option)
        {
            OptionCaption = '"", High,Medium,Low';
            OptionMembers = "", High, Medium, Low;
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            OptionCaption = ' ,Not yet started,Delayed,In progress,Completed';
            OptionMembers = " ", "Not yet started", Delayed, "In progress", Completed;
            DataClassification = ToBeClassified;
        }
        field(12; Comments; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Responsible Person"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job"."Job ID";
        // trigger OnValidate()
        // var
        //     CompanyJob: Record "Company Job";
        // begin
        //     IF CompanyJob.GET(CompanyJob."Job ID", "Responsible Person") THEN
        //         "Responsible Person" := CompanyJob."Job Description";
        // end;
        }
        field(14; "ObjectiveCode"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; InitiativeCode, "Activity Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Activity Code", Activities)
        {
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Validate(InitiativeCode);
    end;
}
