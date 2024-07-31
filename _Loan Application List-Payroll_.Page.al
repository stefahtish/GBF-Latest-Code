page 50655 "Loan Application List-Payroll"
{
    CardPageID = "Loan Application Form-Payroll";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Loan Application";
    SourceTableView = WHERE("Loan Status" = FILTER(<> Issued));
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
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
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
                field("Loan Status"; Rec."Loan Status")
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
                field("Deduction Code"; Rec."Deduction Code")
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
