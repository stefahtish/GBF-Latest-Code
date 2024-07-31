table 50657 "Perfomance SubCriteria"
{
    Caption = 'Perfomance criteria';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Criteria Code"; Code[20])
        {
            Caption = 'Criteria Code';
        }
        field(2; Code; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; TimeFrame; Code[20])
        {
            Caption = 'TimeFrame';
            DataClassification = ToBeClassified;
            TableRelation = "Time Frames"."Time Frame" where(Closed=const(false));
        }
        field(4; Unit; Code[20])
        {
            Caption = 'Unit';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(5; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = ToBeClassified;
        }
        field(6; "Annual  Target"; Decimal)
        {
            Caption = 'Annual  Target';
        }
        field(7; "Q1 Target"; Decimal)
        {
            Caption = 'Q1 Target';
        }
        field(8; "Q2 Target"; Decimal)
        {
            Caption = 'Q2 Target';
        }
        field(9; "Q3 Target"; Decimal)
        {
            Caption = 'Q3 Target';
        }
        field(10; "Q4 Target"; Decimal)
        {
            Caption = 'Q4 Target';
        }
        field(11; Description; Text[2040])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Date of completion"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Criteria Code", Code, TimeFrame)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Criteria Code", Code, Description)
        {
        }
    }
    trigger OnInsert()
    begin
    end;
    var Employee: Record Employee;
    UserSetup: Record "User Setup";
    PlanningSetup: Record "Strategic Planning Setups";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
