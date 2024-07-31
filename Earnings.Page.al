page 50644 Earnings
{
    PageType = List;
    SourceTable = EarningsX;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Show on Master Roll"; Rec."Show on Master Roll")
                {
                }
                field("Basic Salary Code"; Rec."Basic Salary Code")
                {
                }
                field("Applies to All"; Rec."Applies to All")
                {
                }
                field("House Allowance Code"; Rec."House Allowance Code")
                {
                }
                field("Earning Type"; Rec."Earning Type")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field(Block; Rec.Block)
                {
                }
                field("Pay Type"; Rec."Pay Type")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                }
                field("Flat Amount"; Rec."Flat Amount")
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field(Formula; Rec.Formula)
                {
                }
                field(Taxable; Rec.Taxable)
                {
                }
                field("Reduces Tax"; Rec."Reduces Tax")
                {
                }
                field("Non-Cash Benefit"; Rec."Non-Cash Benefit")
                {
                }
                field(Prorate; Rec.Prorate)
                {
                }
                field("Minimum Limit"; Rec."Minimum Limit")
                {
                }
                field("Maximum Limit"; Rec."Maximum Limit")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Show on Report"; Rec."Show on Report")
                {
                }
                field("Per Diem"; Rec."Per Diem")
                {
                }
                field("Leave Allwance"; Rec."Leave Allwance")
                {
                    Caption = 'Leave commutation';
                }
                field("Yearly Bonus"; Rec."Yearly Bonus")
                {
                }
                field("Supension Earnings Percentage"; Rec."Supension Earnings Percentage")
                {
                }
                field("Requires Employee Request"; Rec."Requires Employee Request")
                {
                }
                field("Casual Code"; Rec."Casual Code")
                {
                }
                field("Sacco Earning"; Rec."Sacco Earning")
                {
                }
                field("Transfer Allowance"; Rec."Transfer Allowance")
                {
                }
            }
        }
    }
    actions
    {
        // area(processing)
        // {
        //     action("Mass Update Earnings & Deductions")
        //     {
        //         Caption = 'Mass Update Earnings & Deductions';
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         RunPageOnRec = true;
        //         trigger OnAction()
        //         begin
        //             EarningsMassUpdate.GetEarnings(Rec);
        //             EarningsMassUpdate.Run;
        //         end;
        //     }
        // }
    }
    var
        Payment: Record EarningsX temporary;
        PaymentCode: Code[10];
        "Actions": Option Add,edit,Delete;
        Sources: Option Payment,Deduction,Saving;
        EarningsMassUpdate: Report "Earnings Mass Update";
}
