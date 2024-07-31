table 50507 "Risk Line"
{
    fields
    {
        field(1; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Drivers,Mitigation Proposal,Effects,Value Explanation,Existing Control,KRI(s),Response,M&E,Risk Category,Risk Opportunity';
            OptionMembers = " ", Drivers, "Mitigation Proposal", Effects, "Value Explanation", "Existing Control", "KRI(s)", Response, "M&E", "Risk Category", "Risk Opportunity";
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CASE Type OF Type::"KRI(s)": GetAppetite;
                END;
            end;
        }
        field(5; Target; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Tolerance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Appetite; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date of Completion"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Mitigation Actions"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Mitigation Owner"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value" WHERE("Global Dimension No."=CONST(2));
        }
        field(11; Timelines; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Mitigation Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Not Done,In Progress,Done';
            OptionMembers = " ", "Not Done", "In Progress", Done;
        }
        field(13; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "KRI(s) Status"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Update Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Daily,Weekly,Monthly,Quaterly,Semi Annually,Annually';
            OptionMembers = " ", Daily, Weekly, Monthly, Quaterly, "Semi Annually", Annually;
        }
        field(16; "Risk Category"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Categories";

            trigger OnValidate()
            begin
                IF RiskCategory.GET("Risk Category")THEN BEGIN
                    "Risk Category Description":=RiskCategory.Description;
                END;
            end;
        }
        field(17; "Risk Category Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Risk Opportunity Assessment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Enhance,Exploit,Share,Do Nothing';
            OptionMembers = " ", Enhance, Exploit, Share, "Do Nothing";
        }
        field(19; "M & E Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,KRI,Mitigation';
            OptionMembers = " ", KRI, Mitigation;
        }
        field(20; "ME Line No."; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                GetKRIandMitigation;
            end;
        }
        field(21; "Update Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Update Stopped"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Send to Register"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; KRI; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk KRI";

            //ValidateTableRelation = false;
            trigger OnValidate()
            var
                RiskKRI: Record "Risk KRI";
            begin
                CASE Type OF Type::"KRI(s)": GetAppetite;
                END;
                if RiskKRI.Get(KRI)then Description:=RiskKRI.Description;
            end;
        }
        field(26; Quantification; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Auditor's Response"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No.", Type, "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var RiskHeader: Record "Risk Header";
    RiskCategory: Record "Risk Categories";
    local procedure GetAppetite()
    begin
        TESTFIELD("Document No.");
        IF RiskHeader.GET("Document No.")THEN Appetite:=RiskHeader."Residual Risk (L * I)";
    end;
    local procedure GetKRIandMitigation()
    var
        KRIList: Page "Risk KRI(s)";
        MitigationList: Page "Risk Responses";
        RiskLineRec: Record "Risk Line";
        RiskLineCopy: Record "Risk Line";
    begin
        RiskLineRec.RESET;
        RiskLineRec.SETRANGE("Document No.", "Document No.");
        IF RiskLineRec.FIND('-')THEN BEGIN
            CASE "M & E Type" OF "M & E Type"::KRI: BEGIN
                RiskLineCopy.COPY(RiskLineRec);
                RiskLineCopy.SETRANGE(Type, RiskLineCopy.Type::"KRI(s)");
                KRIList.SETTABLEVIEW(RiskLineCopy);
                KRIList.LOOKUPMODE(TRUE);
                IF KRIList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    MESSAGE('%1 - %2', RiskLineCopy."Line No.", RiskLineCopy.Description);
                    "ME Line No.":=RiskLineCopy."Line No.";
                    Description:=RiskLineCopy.Description;
                END;
            END;
            "M & E Type"::Mitigation: BEGIN
                RiskLineCopy.COPY(RiskLineRec);
                RiskLineCopy.SETRANGE(Type, RiskLineCopy.Type::Response);
                MitigationList.SETTABLEVIEW(RiskLineCopy);
                MitigationList.LOOKUPMODE(TRUE);
                IF MitigationList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    "ME Line No.":=RiskLineCopy."Line No.";
                    Description:=RiskLineCopy.Description;
                END;
            END;
            END;
        END;
    end;
}
