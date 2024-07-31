table 50585 "Sample Target Test AnalysisNew"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Code[20])
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[100])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            TableRelation = "Test Setup";
        }
        field(3; Results; Code[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Specification; Code[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Remarks; Code[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Done By"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sample Test"."Done By" WHERE("Sample ID"=FIELD("Sample ID")));
        }
        field(7; "Checked By"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sample Test"."Done By" WHERE("Sample ID"=FIELD("Sample ID")));
        }
        field(8; "Sample ID"; Code[100])
        {
            Caption = 'Sample Code';
            DataClassification = ToBeClassified;
        }
        field(9; Cluster; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cluster Regions";
        }
        field(10; "Cluster Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Cluster;
            OptionCaption = ' ,Cluster';
        }
    }
    keys
    {
        key(PK; "Entry No.", Code, "Sample ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Sample ID", Code)
        {
        }
    }
}
