table 50202 "ICT WorkPlan Lines2"
{
    Caption = 'ICT WorkPlan Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Reporting Indicator"; Text[500])
        {
            Caption = 'Reporting Indicator';
            DataClassification = ToBeClassified;
        }
        field(4; "Means of Verification"; Text[500])
        {
            Caption = 'Means of Verification';
            DataClassification = ToBeClassified;
        }
        field(5; "Sub Activity"; Text[500])
        {
            Caption = 'Sub Activity';
            DataClassification = ToBeClassified;
        }
        field(6; "Time Frame"; Code[20])
        {
            Caption = 'Time Frame';
            DataClassification = ToBeClassified;
        }
        field(7; "Time Plan"; Code[20])
        {
            Caption = 'Time Plan';
            DataClassification = ToBeClassified;
            TableRelation = "ICT Workplan Time Plans";
        }
        field(8; "Estimated Budget"; Decimal)
        {
            Caption = 'Estimated Budget';
            DataClassification = ToBeClassified;
        }
        field(9; "Activity Code"; Text[500])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Activity"."Activity Code";

            trigger OnValidate()
            var
                Activity: Record "Strategic Activity";
            begin
                "Activity Code":=UpperCase("Activity Code");
                Activity.Reset();
                Activity.SetRange("Activity Code", "Activity Code");
                if Activity.FindFirst()then "Sub Activity":=Activity.Activity2;
            end;
        }
        field(10; "Perfomance Indicator Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Perfomance Indicator Code", "Activity Code", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        WPlan: Record "ICT Workplan";
    begin
        WPlan.Reset();
        WPlan.SetRange("No.", "No.");
        if WPlan.FindFirst()then "Time Frame":=WPlan."Time Frame";
    end;
}
