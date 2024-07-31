page 50425 "Succession Planning"
{
    PageType = Card;
    SourceTable = Employee;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field(Initials; Rec.Initials)
                {
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                }
                field("Taxable Allowance"; Rec."Taxable Allowance")
                {
                }
                field("Position TO Succeed"; Rec."Position TO Succeed")
                {
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                }
            }
        }
    }
    actions
    {
    }
}
