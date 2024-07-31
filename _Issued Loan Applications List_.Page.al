page 50678 "Issued Loan Applications List"
{
    CardPageID = "Loan Application Form-Payroll";
    Editable = false;
    PageType = List;
    SourceTable = "Loan Application";
    SourceTableView = WHERE("Loan Status" = FILTER(Issued));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Loan No"; Rec."Loan No")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                }
                field("Amount Requested"; Rec."Amount Requested")
                {
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                }
                field("Issued Date"; Rec."Issued Date")
                {
                }
                field(Instalment; Rec.Instalment)
                {
                }
                field(Repayment; Rec.Repayment)
                {
                }
                field("Flat Rate Principal"; Rec."Flat Rate Principal")
                {
                }
                field("Flat Rate Interest"; Rec."Flat Rate Interest")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
            }
        }
    }
    actions
    {
    }
    var
        GetGroup: Codeunit Payroll;
        GroupCode: Code[20];
        CUser: Code[20];
}
