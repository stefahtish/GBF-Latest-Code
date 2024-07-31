table 50499 "Audit Setup"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Audit Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "Risk Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Audit Notification Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(5; "Risk Reporting Nos."; Code[20])
        {
            Caption = 'Risk Setup Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6; "Incident Reporting Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7; "Audit Workplan Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8; "Audit Record Requisition Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(9; "Risk Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(10; "Audit Plan Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(11; "Work Paper Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(12; "Audit Report Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(13; "Risk Survey Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(14; "Attachment Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Audit Program Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(16; "Report Deadline Reminder"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Workplan Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Monthly,Quaterly,Mid-Year,Annual';
            OptionMembers = " ", Monthly, Quaterly, "Mid-Year", Annual;
        }
        field(18; "Organazation Workplan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(19; "Department Workplan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(20; "Risk Survey Threshold"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Compliance Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(22; "Organization Threshold"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Department Threshold"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Project Threshold"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Risk Officer Job ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job";

            trigger OnValidate()
            begin
                IF CompanyJob.GET("Risk Officer Job ID")THEN "Risk Officer Job Description":=CompanyJob."Job Description";
            end;
        }
        field(26; "Risk Officer Job Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Notification Update Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Project Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(29; "Risk KRI Guideline Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(30; "Risk Register Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(31; "Escalation Due Date"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Escalation Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Escalation CC"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Inspection Report Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(35; "Strategic Audit Plan Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(36; "Quarterly Audit Plan Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var CompanyJob: Record "Company Job";
}
