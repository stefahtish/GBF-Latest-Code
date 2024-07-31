page 50656 "Loan Product Type list-Payroll"
{
    CardPageID = "Loan Product Type Setup";
    Editable = false;
    PageType = List;
    SourceTable = "Loan Product Type";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                }
                field("No Series"; Rec."No Series")
                {
                }
                field("No of Instalment"; Rec."No of Instalment")
                {
                }
                field("Loan No Series"; Rec."Loan No Series")
                {
                }
                field(Rounding; Rec.Rounding)
                {
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                }
            }
        }
    }
    actions
    {
    }
}
