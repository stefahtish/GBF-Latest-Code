page 50687 "Trustee Payment Lines"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Trustee Reversal Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Trustee No"; Rec."Trustee No")
                {
                }
                field("Trustee Name"; Rec."Trustee Name")
                {
                }
                field("Pay Period"; Rec."Pay Period")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                }
                field("Taxable Allowance"; Rec."Taxable Allowance")
                {
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                }
                field("Net Pay"; Rec."Net Pay")
                {
                }
            }
        }
    }
    actions
    {
    }
}
