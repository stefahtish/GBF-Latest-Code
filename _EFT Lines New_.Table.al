table 50413 "EFT Lines New"
{
    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CashMgmt: record "Cash Management Setups";
                NoSeriesMgmt: Codeunit NoSeriesManagement;
                CompInfo: Record "Company Information";
            begin
                CompInfo.Get();
                CashMgmt.Get;
                CashMgmt.TestField("EFT Payee Reference Nos");
                CashMgmt.TestField("EFT Serial No");
                if PaymentsRec.get("No.")then;
                PaymentLines.reset;
                PaymentLines.setrange(No, "No.");
                PaymentLines.SetRange("Line No", "Line No.");
                if PaymentLines.findfirst()then begin
                    PaymentLines.CalcFields("Pay Mode Type");
                    Date:=PaymentsRec.Date;
                    Payee:=PaymentLines.Payee;
                    if PaymentLines."Pay Mode" <> '' then "Pay Mode":=PaymentLines."Pay Mode";
                    "Pay Mode":=CashMgmt."Pay Mode";
                    Currency:=CashMgmt."Default Currency Code";
                    "Payment Description1":=CashMgmt."Payment Description1" + ' ' + NoSeriesMgmt.GetNextNo(CashMgmt."EFT Serial No", 0D, TRUE);
                    "Payment Description2":="Payment Description1";
                    "Payment Description3":="Payment Description1";
                    "Payment Description4":="Payment Description1";
                    "Debit Narrative":="Debit Narrative";
                    "Credit Narrative":="Credit Narrative";
                    "Purpose Pay":=Format(Date, 0, '<Month Text,3>') + ' ' + CashMgmt."Purpose Pay";
                    "Paying Bank Account":=CompInfo."Bank Account No.";
                    "Shortcut Dimension 1 Code":=PaymentsRec."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=PaymentsRec."Shortcut Dimension 2 Code";
                    Payeeesc:=DELCHR(PaymentLines."Payee Account Name", '=', ' ');
                    Payeeesc:=uppercase(format(Payeeesc, 4));
                    "Customer Ref":='P' + Payeeesc + Format(Today, 0, '<Day,2><Month,2><Year4>') + NoSeriesMgmt.GetNextNo(CashMgmt."EFT Payee Reference Nos", 0D, TRUE);
                    Modify;
                    if Customer.Get(PaymentLines."Account No")then begin
                        "Payee Email":=Customer."E-Mail";
                        "Payee Bank Code":=Customer."Bank Code";
                        "Payee Bank Branch Code":=Customer."Bank Branch Code";
                        "Payee Bank Account No":=Customer."Bank Account No";
                        "Payee Bank Account Name":=Customer."Bank Code Name";
                    end;
                    if Vendor.get(PaymentLines."Account No")then begin
                        "Payee Email":=Vendor."E-Mail";
                        "Payee Bank Code":=Vendor."Vendor Bank Code";
                        "Payee Bank Branch Code":=Vendor."Vendor Bank Branch Code";
                        "Payee Bank Account No":=Vendor."Vendor Bank Account No";
                        "Payee Bank Account Name":=Vendor."Bank Account Name";
                    end;
                    "Payee Name":=PaymentLines."Account Name";
                    "Pop Code":=CashMgmt."POP Code";
                    "On behalf of":=PaymentsRec."On behalf of";
                    "Created By":=PaymentsRec."Created By";
                    Cashier:=PaymentsRec.Cashier;
                // "Payee Bank Code" := PaymentLines."Payee Bank Code";
                // "Payee Bank Branch Code" := PaymentLines."Payee Bank Branch Code";
                // "Payee Bank Account No" := PaymentLines."Payee Bank Account No";
                // "Payee Bank Account Name" := PaymentLines."Payee Account Name";
                // "Payment Narration" := PaymentsRec."Payment Narration";
                end;
            end;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Pay Mode"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(8; Payee; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "On behalf of"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Budget Holder Region';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(15; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Budget Holder Department';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(17; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Paying Bank Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Payment Voucher,Imprest,Staff Claim,Imprest Surrender,Petty Cash,Bank Transfer,Petty Cash Surrender,Receipt,Staff Advance,Receipt-Property,Sponsor Receipt,EFT File Gen';
            OptionMembers = "Payment Voucher", Imprest, "Staff Claim", "Imprest Surrender", "Petty Cash", "Bank Transfer", "Petty Cash Surrender", Receipt, "Staff Advance", "Receipt-Property", "Sponsor Receipt", "EFT File Gen";
        }
        field(21; Currency; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(42; Cashier; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Payment Release Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Payment Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(89; "Total VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Total Witholding Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Total Net Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2: 2;
        }
        field(50144; "Payment Description1"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50145; "Payment Description2"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50146; "Payment Description3"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50147; "Payment Description4"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50148; "Debit Narrative"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50149; "Credit Narrative"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50150; "Purpose Pay"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50151; "Payee Name"; Code[50])
        {
        }
        field(50152; "Pop Code"; Code[50])
        {
            TableRelation = "POP Codes";
        }
        field(70000; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "PV Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "Payee Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks.Code;

            trigger OnValidate()
            begin
                if Banks.Get("Payee Bank Code")then "Payee Bank Code Name":=Banks.Name
                else
                    "Payee Bank Code Name":='';
            end;
        }
        field(70004; "Payee Bank Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" WHERE("Bank Code"=FIELD("Payee Bank Code"));

            trigger OnValidate()
            begin
                if BankBranchess.Get("Payee Bank Code", "Payee Bank Branch Code")then "Payee Bank Branch Name":=BankBranchess."Branch Name"
                else
                    "Payee Bank Branch Name":='';
            end;
        }
        field(70005; "Payee Bank Account No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70006; "Payee Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70007; "Payee Bank Code Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70008; "Payee Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70009; "Customer Ref"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70010; "Payee Email"; Text[100])
        {
            //ObsoleteState = Removed;
            DataClassification = ToBeClassified;
        }
        field(70011; "PRN"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Payments.PRN where("No."=field("No.")));
        }
        field(70012; "Document Path"; Text[100])
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(70013; "Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(700142; "Pmt Document Path"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Payment Method"."Document Path" where(Code=field("Pay Mode")));
        }
        field(700143; "Payee Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(700144; Status; Option)
        {
            OptionMembers = UnProcessed, Processed, Rejected;
            DataClassification = ToBeClassified;
        }
        field(700145; "S2B Customer Ref"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No.", "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
    //"Line No." := GetNextLineNo();
    end;
    var Banks: Record Banks;
    BankBranchess: Record "Bank Branches";
    PaymentsRec: Record Payments;
    PaymentLines: Record "Payment Lines";
    Payments2: Record Payments;
    Customer: Record Customer;
    Vendor: Record Vendor;
    CustomerBank: Record "Customer Bank Account";
    Payeeesc: Text[100];
    procedure GetNextLineNo(): Integer var
        EFTLines: Record "EFT Lines New";
    begin
        EFTLines.Reset();
        EFTLines.SetCurrentKey("Document No.", "Line No.");
        if EFTLines.FindLast()then exit(EFTLines."Line No." + 1)
        else
            exit(1);
    end;
}
