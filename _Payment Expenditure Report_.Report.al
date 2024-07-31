report 50331 "Payment Expenditure Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Payment Expenditure Report.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Payments Header"; "Payments Header")
        {
            DataItemTableView = WHERE("Payment Type" = CONST(Normal), Status = CONST(Posted));
            RequestFilterFields = "Payment Release Date", "Global Dimension 1 Code", "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code";

            column(Payee; "Payments Header".Payee)
            {
            }
            column(Date; "Payments Header"."Payment Release Date")
            {
            }
            column(No; "Payments Header"."No.")
            {
            }
            column(PaymentNarration; "Payments Header"."Payment Narration")
            {
            }
            column(ResponsibilityCenter; "Payments Header"."Responsibility Center")
            {
            }
            column(TotalPaymentAmount; GrossAmt)
            {
            }
            column(ShortcutDimension3Code; "Payments Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code; "Payments Header"."Shortcut Dimension 4 Code")
            {
            }
            column(TotalNetAmount; "Payments Header"."Total Net Amount")
            {
            }
            column(CurrencyCode; "Payments Header"."Currency Code")
            {
            }
            column(TotalWitholdingTaxAmount; "Payments Header"."Total Witholding Tax Amount")
            {
            }
            column(FunctionName; "Payments Header"."Function Name")
            {
            }
            column(ShortcutDimension2Code; "Payments Header"."Shortcut Dimension 2 Code")
            {
            }
            column(GlobalDimension1Code; "Payments Header"."Global Dimension 1 Code")
            {
            }
            column(Dim3_PaymentsHeader; "Payments Header".Dim3)
            {
            }
            column(Dim4_PaymentsHeader; "Payments Header".Dim4)
            {
            }
            column(BudgetCenterName; "Payments Header"."Budget Center Name")
            {
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Total Witholding Tax Amount", "Total Net Amount");
                GrossAmt := "Total Witholding Tax Amount" + "Total Net Amount";
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        GrossAmt: Decimal;
}
