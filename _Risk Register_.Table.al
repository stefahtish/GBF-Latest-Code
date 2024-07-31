table 50505 "Risk Register"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Corporate,Department,Project';
            OptionMembers = " ", Corporate, Department, Project;
        }
        field(3; Category; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Value at Risk"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Value at Risk Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Gross (L*I)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Existing Control / Mitigation"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Residual (L*I)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "KRI(s) Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Mitigation Action"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Mitigation Owner"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "KRI(s) Status"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Comment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Archive; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(18; "Risk Description"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(19; "Risk Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Risk,Risk Opportunity';
            OptionMembers = " ", Risk, "Risk Opportunity";
        }
        field(20; "Project Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Risk Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Drivers,Mitigation Proposal,Effects,Value Explanation,Existing Control,KRI(s),Response,M&E,Risk Category,Risk Opportunity';
            OptionMembers = " ", Drivers, "Mitigation Proposal", Effects, "Value Explanation", "Existing Control", "KRI(s)", Response, "M&E", "Risk Category", "Risk Opportunity";
        }
        field(22; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Mitigation Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Not Done,In Progress,Done';
            OptionMembers = " ", "Not Done", "In Progress", Done;
        }
        field(24; SurveyType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Survey, Register;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
