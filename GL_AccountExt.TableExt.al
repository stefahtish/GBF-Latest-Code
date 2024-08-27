tableextension 50155 GL_AccountExt extends "G/L Account"
{
    fields
    {
        field(50000; "Revenue Account Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "G/L Account"."No.";
        }
        field(50001; "Expense Account Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "G/L Account"."No.";
        }
        field(50002; "Investment AC"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Investment Posting"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
        field(50004; "Investment Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50005; "Investment A/C Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,Share-split,Premium,Discounts,Other Income,Expenses,Loan Repayment,Subsidy';
            OptionMembers = ,Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,"Share-split",Premium,Discounts,"Other Income",Expenses,"Loan Repayment",Subsidy;
        }
        field(50006; "Global Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,1,6';
            Caption = 'Global Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(50007; "Global Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,1,7';
            Caption = 'Global Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(50008; "Global Dimension 6 Filter"; Code[20])
        {
            CaptionClass = '1,3,6';
            Caption = 'Global Dimension 6 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(50009; "Global Dimension 7 Filter"; Code[20])
        {
            CaptionClass = '1,3,7';
            Caption = 'Global Dimension 7 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(50010; "Receivable Acc"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Customer Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group";
        }
        field(50012; "Debt Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Budget Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "User ID Filter"; Code[50])
        {
            FieldClass = FlowFilter;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(50015; "Disbursed Budget"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."), "G/L Account No." = FIELD(FILTER(Totaling)), "Business Unit Code" = FIELD("Business Unit Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), Date = FIELD("Date Filter"), "Budget Name" = FIELD("Budget Filter"), "Budget Dimension 1 Code" = FIELD("Shortcut Dimension 3 Filter"), "Budget Dimension 2 Code" = FIELD("Shortcut Dimension 4 Filter"), "Budget Dimension 3 Code" = FIELD("Shortcut Dimension 3 Filter"), "Budget Dimension 4 Code" = FIELD("Shortcut Dimension 6 Filter"), "Dimension Set ID" = FIELD("Dimension Set ID Filter")));
        }
        field(50016; "Approved Budget"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."), "G/L Account No." = FIELD(FILTER(Totaling)), "Business Unit Code" = FIELD("Business Unit Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), Date = FIELD(UPPERLIMIT("Date Filter")), "Budget Name" = FIELD("Budget Filter"), "Budget Dimension 1 Code" = FIELD("Shortcut Dimension 3 Filter"), "Budget Dimension 2 Code" = FIELD("Shortcut Dimension 4 Filter"), "Budget Dimension 3 Code" = FIELD("Shortcut Dimension 5 Filter"), "Budget Dimension 4 Code" = FIELD("Shortcut Dimension 6 Filter"), "Dimension Set ID" = FIELD("Dimension Set ID Filter")));
        }
        field(50018; "Shortcut Dimension 3 Filter"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No." = const(3));
            CaptionClass = '1,2,3';
        }
        field(50019; "Shortcut Dimension 4 Filter"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No." = const(4));
            CaptionClass = '1,3,2';
        }
        field(50020; "Shortcut Dimension 5 Filter"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No." = const(5));
            CaptionClass = '1,3,2';
        }
        field(50021; "Shortcut Dimension 6 Filter"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No." = const(6));
            CaptionClass = '1,3,2';
        }
        field(50022; Commitment; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE(Account = FIELD("No."), "Commitment Date" = FIELD("Date Filter"), "Global Dimension 1" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2" = FIELD("Global Dimension 2 Filter"), Account = FIELD(FILTER(Totaling)), "Commitment Type" = FILTER(Commitment | "Commitment Reversal"), "Dimension Set ID" = FIELD("Dimension Set ID Filter"), "Budget Code" = FIELD("Budget Filter")));
        }
        field(50023; Encumberance; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE(Account = FIELD("No."), "Commitment Date" = FIELD("Date Filter"), "Global Dimension 1" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2" = FIELD("Global Dimension 2 Filter"), Account = FIELD(FILTER(Totaling)), "Commitment Type" = FILTER(Encumberance | "Encumberance Reversal"), "Dimension Set ID" = FIELD("Dimension Set ID Filter"), "Budget Code" = FIELD("Budget Filter")));
        }
        field(50024; "Current Budget"; Code[20])
        {
        }
        field(50025; "Votebook Entry"; Boolean)
        {
        }
    }
    var
        CreateGL: Label 'Do you want to create this G/L Account in %1 Company?';

    procedure ReplicateGLAcc()
    var
        CompanyRec: Record Company;
        GLAccount: Record "G/L Account";
        GLAccount2: Record "G/L Account";
    begin
        GLAccount.Copy(Rec);
        CompanyRec.Reset;
        CompanyRec.SetFilter(Name, '<>%1', CompanyName);
        if CompanyRec.Find('-') then begin
            repeat
                GLAccount2.ChangeCompany(CompanyRec.Name);
                if not GLAccount2.Get(GLAccount."No.") then begin
                    if Confirm(CreateGL, false, CompanyRec.Name) then;
                    GLAccount2.Init;
                    GLAccount2.TransferFields(GLAccount);
                    GLAccount2.Insert;
                end;
            until CompanyRec.Next = 0;
        end;
    end;
}
