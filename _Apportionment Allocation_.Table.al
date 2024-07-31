table 50157 "Apportionment Allocation"
{
    fields
    {
        field(1; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Company; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company.Name;
        }
        field(3; Allocation; Decimal)
        {
            Caption = 'Allocation (%)';
            DataClassification = ToBeClassified;
        }
        field(4; "Posted Doc No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Expense Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TotalAmount:=0;
                if Amount > 0 then;
                if Type = Type::Amount then begin
                    Payments.Reset;
                    Payments.SetRange("No.", "Document No.");
                    if Payments.FindFirst then begin
                        Payments.CalcFields("Total Amount", "Total Net Amount");
                        TotalAmount:=Payments."Total Amount";
                    end;
                    PurchaseHeader.Reset;
                    PurchaseHeader.SetRange("No.", "Document No.");
                    if PurchaseHeader.FindFirst then begin
                        PurchaseHeader.CalcFields(Amount, "Amount Including VAT");
                        TotalAmount:=PurchaseHeader."Amount Including VAT";
                    end;
                    ApportionmentTotals.Reset;
                    ApportionmentTotals.SetRange("No.", "Document No.");
                    if ApportionmentTotals.FindFirst then begin
                        ApportionmentTotals.CalcFields("Total Amount");
                        TotalAmount:=ApportionmentTotals."Total Amount";
                    end;
                    if Amount > TotalAmount then Error('Amount can not be greater than Total Amount');
                    Allocation:=(Amount / TotalAmount) * 100;
                end;
            end;
        }
        field(8; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage, Amount;
        }
    }
    keys
    {
        key(Key1; "Document No.", Company)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var TotalAmount: Decimal;
    Payments: Record Payments;
    PurchaseHeader: Record "Purchase Header";
    ApportionmentTotals: Record "Apportionment Totals";
}
