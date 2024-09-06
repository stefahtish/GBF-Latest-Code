tableextension 50159 Gen_JournalExt extends "Gen. Journal Line"
{
    fields
    {
        field(51002; "Investment Transcation Type"; Enum "Investment Transaction Types")
        {
        }
        field(51004; Portfolio; Code[50])
        {
        }
        field(51018; Consumption; Decimal)
        {
        }
        field(51019; Rate; Decimal)
        {
        }
        field(51021; Narration; Text[250])
        {
        }
        field(51024; "Asset Type"; Enum "Asset Types")
        {
        }
        field(51014; "EFT Reference"; Code[50])
        {
        }
        field(51025; "Fund No."; Code[20])
        {
        }
        field(51026; "Funding Transaction Type"; Enum "Funding Transaction Type")
        {
        }
        field(51027; "Bond Application No."; Code[20])
        {
        }
        field(51038; "No. Of Units"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Investment Transcation Type" = "Investment Transcation Type"::Disposal THEN BEGIN
                    "No. Of Units" := -ABS("No. Of Units");
                END
                ELSE
                    "No. Of Units" := ABS("No. Of Units");
            end;
        }
        field(51040; "Expected Receipt date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51043; "GL Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51046; Payee; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51028; "Investment Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            begin
                /* IF InvestmentRec.GET("Investment Code") THEN;
                     IF InvestmentRec."Asset Type" <> InvestmentRec."Asset Type"::Equity THEN BEGIN
                         IF "Investment Transcation Type" = "Investment Transcation Type"::Acquisition THEN
                             "Nominal Value" := Amount;
                     END;*/
            end;
        }
        field(51030; "Nominal Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Investment Transcation Type" = "Investment Transcation Type"::Disposal THEN BEGIN
                    "Nominal Value" := -ABS("Nominal Value");
                END
                ELSE
                    "Nominal Value" := ABS("Nominal Value");
            end;
        }
        field(51060; "Sponsor Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51044; Arrears; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51045; "Transfer In"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51056; "Investment Posting"; Boolean)
        {
        }
        field(51057; "Property Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51058; "Transaction Code2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51059; "Tenant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51070; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Income,Expense,Receipt,PV';
            OptionMembers = " ",Income,Expense,Receipt,PV;
        }
        field(51061; "LandLord No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(51062; "Property Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51063; "L.R No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51064; "Property Floor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51065; Rent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51066; "Service Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51067; "Property Unit code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51068; "Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51096; "Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51100; "Invest Book Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51101; "Invest Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51102; "Property Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Acquisition Cost,Revaluation,Revenue,Maintenance,Tenant Purchase,Interest,Repayments,Accrued Income,Interest Paid';
            OptionMembers = "Acquisition Cost",Revaluation,Revenue,Maintenance,"Tenant Purchase",Interest,Repayment,"Accrued Income","Interest Paid";
        }
        field(51103; "Lease No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51105; Institution; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51106; Broker; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51107; "Stock Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51108; "Issue No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51109; "Investment Class"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51110; Custodian; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51112; "Property Receipt Type"; Option)
        {
            Caption = 'Property Transaction Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Rent Receipt,Service Charge,TPS Repayment,TPS Deposit';
            OptionMembers = " ","Rent Receipt","Service Charge","TPS Repayment","TPS Deposit";
        }
        field(51113; "Period Reference"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period"."Starting Date";

            trigger OnValidate()
            var
                PeriodRec: Record "Accounting Period";
            begin
            end;
        }
        field(51114; Apportioned; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51115; "Parking Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51116; "Emp Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51117; "TPS Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Principal Due,Interest Due,Arrears,Penalty Due,Principal Repayment,Interest Repayment,Penalty Paid,Service Charge Due,Service Charge Paid';
            OptionMembers = " ","Principle Due","Interest Due",Arrears,"Penalty Due","Principle Repayment","Interest Repayment","Penalty Paid","Service Charge Due","Service Charge Paid";
        }
        field(51118; "TPS Repayement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51119; Deposit; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Indicated TPS/Property Lease Deposit Amount';
        }
        field(51120; "TPS Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51121; "TPS Invoice No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51122; "Emp Payroll Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51123; "TPS Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51124; "Loan Transaction Type"; Enum LoanTransactionTypes)
        {
            Caption = 'Loan Transaction Type';
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     LoanProduct: Record "Loan Product Setup";
            //     LoanRec: Record "Loans Register";
            //     LoanTransPriority: Record "Transaction Type Priority";
            // begin
            //     if LoanRec.Get("Loan No") then;
            //     if LoanProduct.get(LoanRec."Loan Product Type") then begin
            //         LoanTransPriority.Get(LoanProduct.Code, "Loan Transaction Type");
            //         "Transaction Priority" := LoanTransPriority.Priority;
            //     end;
            // end;
        }
        field(51125; "Loan No"; Code[50])
        {
            Caption = 'Loan No';
            DataClassification = ToBeClassified;
        }
        field(51126; "Extra Payment"; Boolean)
        {
            Caption = 'Extra Payment';
            DataClassification = ToBeClassified;
        }
        field(51127; "Transaction Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51128; "General Expense Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51129; "Customer Transaction Type"; Enum "Customer Transaction Types")
        {
            DataClassification = ToBeClassified;
        }
        field(60058; "Transaction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    var
        InvestmentRec: Record "Fixed Asset";
        Gain_Loss: Decimal;
        Cost: Decimal;
        Sponsor: Record Vendor;
        JournalAmount: Decimal;
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        Text020: Label 'Do you want to send the report via mail?';
}
