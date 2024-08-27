tableextension 50156 GL_EntryExt extends "G/L Entry"
{
    fields
    {
        field(50000; "Investment Transactin Type"; Enum "Investment Transaction Types")
        {
        }
        field(50001; "Asset Type"; Enum "Asset Types")
        {
        }
        field(50002; "Funding Transaction Type"; Enum "Funding Transaction Type")
        {
        }
        field(50003; "Bond Application No."; Code[20])
        {
        }
        field(50004; "Investment Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";
        }
        field(50005; "No. Of Units"; Decimal)
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
        field(50006; "Nominal Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; PDateExt; Date)
        {
        }
        field(50008; Dim1Ext; code[20])
        {
        }
        field(50009; Dim2Ext; Code[20])
        {
        }
        field(50010; AmtExt; Decimal)
        {
        }
        field(50011; "Property Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Transaction Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Entry Type[Income/expense]"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ",Income,Expense;
        }
        field(50014; "Lease No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Rent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Service Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Property Floor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Property Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Charge code"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Property Transaction Type"; Option)
        {
            Caption = 'FA Posting Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Acquisition Cost,Revaluation,Revenue,Maintenance,Tenant Purchase,Interest,Repayments,Accrued Income,Interest Paid';
            OptionMembers = "Acquisition Cost",Revaluation,Revenue,Maintenance,"Tenant Purchase",Interest,Repayment,"Accrued Income","Interest Paid";
        }
        field(50021; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Property Receipt Type"; Option)
        {
            Caption = 'Property Transaction Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Rent Receipt,Service Charge,TPS Repayment,TPS Deposit';
            OptionMembers = " ","Rent Receipt","Service Charge","TPS Repayment","TPS Deposit";
        }
        field(50023; "Period Reference"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period"."Starting Date";

            trigger OnValidate()
            var
                PeriodRec: Record "Accounting Period";
            begin
            end;
        }
        field(50024; Apportioned; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Emp Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "TPS Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Principal Due,Interest Due,Arrears,Penalty Due,Principal Repayment,Interest Repayment,Penalty Paid,Service Charge Due,Service Charge Paid';
            OptionMembers = " ","Principle Due","Interest Due",Arrears,"Penalty Due","Principle Repayment","Interest Repayment","Penalty Paid","Service Charge Due","Service Charge Paid";
        }
        field(50027; "TPS Repayement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; Deposit; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Indicated TPS/Property Lease Deposit Amount';
        }
        field(50029; "TPS Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "TPS Invoice No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Loan Transaction Type"; Enum LoanTransactionTypes)
        {
            Caption = 'Loan Transaction Type';
            DataClassification = ToBeClassified;
        }
        field(50032; "Loan No"; Code[50])
        {
            Caption = 'Loan No';
            DataClassification = ToBeClassified;
        }
        field(50033; "Extra Payment"; Boolean)
        {
            Caption = 'Extra Payment';
            DataClassification = ToBeClassified;
        }
        field(50034; "General Expense Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "General Expense Code1"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}
