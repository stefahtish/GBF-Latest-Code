page 50664 "Hotel Bills Header Card"
{
    PageType = Card;
    SourceTable = "Hotel Bill Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field("Total Bill Amount"; Rec."Total Bill Amount")
                {
                }
                field("Customer No"; Rec."Customer No")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("No Series"; Rec."No Series")
                {
                }
                part(Control12; "Hotel Bill Lines")
                {
                    SubPageLink = No = FIELD(No);
                }
            }
        }
    }
    actions
    {
    }
}
