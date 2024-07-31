tableextension 50156 GL_EntryExt extends "G/L Entry"
{
    fields
    {
        field(50001; "Investment Transactin Type";Enum "Investment Transaction Types")
        {
        }
        field(50002; "Asset Type";Enum "Asset Types")
        {
        }
        field(50005; "Funding Transaction Type";Enum "Funding Transaction Type")
        {
        }
        field(50006; "Bond Application No."; Code[20])
        {
        }
        field(50031; "Investment Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";
        }
        field(50032; "No. Of Units"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /* IF "Receipt Payment Type"="Receipt Payment Type"::"Unit Trust" THEN BEGIN
                 IF Brokers.GET("Unit Trust Member No") THEN BEGIN
                
                 Brokers.CALCFIELDS("No.Of Units","Acquisition Cost","Current Value",Revaluations);
                 IF "No. Of Units">Brokers."No.Of Units" THEN
                  ERROR('You cannot redeem more units than you have!!');
                
                
                   IF  Brokers."No.Of Units" >0 THEN
                // "Current unit price":=Brokers."Current Value"/Brokers."No.Of Units" ;
                 //"Price Per Share":="Current unit price";
                VALIDATE("Price Per Share");
                VALIDATE(Amount);
                  END;
                
                 END ELSE BEGIN
                  IF "No. Of Units"<0 THEN
                  ERROR('You Cannot Sale Negative No. of Shares!!');
                
                   VALIDATE(Amount);
                 END;*/
            end;
        }
        field(60030; "Nominal Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90000; PDateExt; Date)
        {
        }
        field(90001; Dim1Ext; code[20])
        {
        }
        field(90002; Dim2Ext; Code[20])
        {
        }
        field(90003; AmtExt; Decimal)
        {
        }
        field(9585; "Property Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9586; "Transaction Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9590; "Entry Type[Income/expense]"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ", Income, Expense;
        }
        field(9591; "Lease No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9613; Rent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9614; "Service Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9615; "Property Floor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9616; "Property Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9617; "Charge code"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(9702; "Property Transaction Type"; Option)
        {
            Caption = 'FA Posting Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Acquisition Cost,Revaluation,Revenue,Maintenance,Tenant Purchase,Interest,Repayments,Accrued Income,Interest Paid';
            OptionMembers = "Acquisition Cost", Revaluation, Revenue, Maintenance, "Tenant Purchase", Interest, Repayment, "Accrued Income", "Interest Paid";
        }
        field(9703; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9704; "Property Receipt Type"; Option)
        {
            Caption = 'Property Transaction Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Rent Receipt,Service Charge,TPS Repayment,TPS Deposit';
            OptionMembers = " ", "Rent Receipt", "Service Charge", "TPS Repayment", "TPS Deposit";
        }
        field(9705; "Period Reference"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period"."Starting Date";

            trigger OnValidate()
            var
                PeriodRec: Record "Accounting Period";
            begin
            end;
        }
        field(9706; Apportioned; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9707; "Emp Payroll Period"; Date)
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
        field(51520000; "Loan Transaction Type";Enum LoanTransactionTypes)
        {
            Caption = 'Loan Transaction Type';
            DataClassification = ToBeClassified;
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
        field(51520003; "General Expense Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51520005; "General Expense Code1"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}
