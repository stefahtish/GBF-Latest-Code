tableextension 50159 Gen_JournalExt extends "Gen. Journal Line"
{
    fields
    {
        field(50002; "Investment Transcation Type";Enum "Investment Transaction Types")
        {
        }
        field(50004; Portfolio; Code[50])
        {
        }
        field(50018; Consumption; Decimal)
        {
        }
        field(50019; Rate; Decimal)
        {
        }
        field(50021; Narration; Text[250])
        {
        }
        field(50024; "Asset Type";Enum "Asset Types")
        {
        }
        field(50014; "EFT Reference"; Code[50])
        {
        }
        field(50025; "Fund No."; Code[20])
        {
        }
        field(50026; "Funding Transaction Type";Enum "Funding Transaction Type")
        {
        }
        field(50027; "Bond Application No."; Code[20])
        {
        }
        field(50038; "No. Of Units"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Investment Transcation Type" = "Investment Transcation Type"::Disposal THEN BEGIN
                    "No. Of Units":=-ABS("No. Of Units");
                END
                ELSE
                    "No. Of Units":=ABS("No. Of Units");
            end;
        }
        field(50040; "Expected Receipt date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "GL Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50046; Payee; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60028; "Investment Code"; Code[50])
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
        field(60030; "Nominal Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Investment Transcation Type" = "Investment Transcation Type"::Disposal THEN BEGIN
                    "Nominal Value":=-ABS("Nominal Value");
                END
                ELSE
                    "Nominal Value":=ABS("Nominal Value");
            end;
        }
        field(60043; "Sponsor Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60044; Arrears; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60045; "Transfer In"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60056; "Investment Posting"; Boolean)
        {
        }
        field(60057; "Property Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60058; "Transaction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60059; "Tenant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60060; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Income,Expense,Receipt,PV';
            OptionMembers = " ", Income, Expense, Receipt, PV;
        }
        field(60061; "LandLord No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(60062; "Property Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60063; "L.R No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60064; "Property Floor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60065; Rent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60066; "Service Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60067; "Property Unit code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60068; "Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9600; "Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9700; "Invest Book Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9701; "Invest Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9702; "Property Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Acquisition Cost,Revaluation,Revenue,Maintenance,Tenant Purchase,Interest,Repayments,Accrued Income,Interest Paid';
            OptionMembers = "Acquisition Cost", Revaluation, Revenue, Maintenance, "Tenant Purchase", Interest, Repayment, "Accrued Income", "Interest Paid";
        }
        field(9703; "Lease No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9705; Institution; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9706; Broker; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9707; "Stock Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9708; "Issue No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9709; "Investment Class"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9710; Custodian; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9712; "Property Receipt Type"; Option)
        {
            Caption = 'Property Transaction Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Rent Receipt,Service Charge,TPS Repayment,TPS Deposit';
            OptionMembers = " ", "Rent Receipt", "Service Charge", "TPS Repayment", "TPS Deposit";
        }
        field(9713; "Period Reference"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period"."Starting Date";

            trigger OnValidate()
            var
                PeriodRec: Record "Accounting Period";
            begin
            end;
        }
        field(9714; Apportioned; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9715; "Parking Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9716; "Emp Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9717; "TPS Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Principal Due,Interest Due,Arrears,Penalty Due,Principal Repayment,Interest Repayment,Penalty Paid,Service Charge Due,Service Charge Paid';
            OptionMembers = " ", "Principle Due", "Interest Due", Arrears, "Penalty Due", "Principle Repayment", "Interest Repayment", "Penalty Paid", "Service Charge Due", "Service Charge Paid";
        }
        field(9718; "TPS Repayement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9719; Deposit; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Indicated TPS/Property Lease Deposit Amount';
        }
        field(9720; "TPS Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9721; "TPS Invoice No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9722; "Emp Payroll Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9723; "TPS Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51520000; "Loan Transaction Type";Enum LoanTransactionTypes)
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
        field(51520001; "Loan No"; Code[50])
        {
            Caption = 'Loan No';
            DataClassification = ToBeClassified;
        }
        field(51520002; "Extra Payment"; Boolean)
        {
            Caption = 'Extra Payment';
            DataClassification = ToBeClassified;
        }
        field(51520004; "Transaction Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51520005; "General Expense Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51520006; "Customer Transaction Type";enum "Customer Transaction Types")
        {
            DataClassification = ToBeClassified;
        }
    }
    var InvestmentRec: Record "Fixed Asset";
    Gain_Loss: Decimal;
    Cost: Decimal;
    Sponsor: Record Vendor;
    JournalAmount: Decimal;
    LineNo: Integer;
    GenJnlLine: Record "Gen. Journal Line";
    GenJnlLine2: Record "Gen. Journal Line";
    Text020: Label 'Do you want to send the report via mail?';
}
