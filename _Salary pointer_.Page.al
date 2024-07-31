page 50642 "Salary pointer"
{
    PageType = List;
    SourceTable = "Salary Pointer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Salary Scale"; Rec."Salary Scale")
                {
                    Editable = false;
                    Visible = true;
                }
                field("Salary Pointer"; Rec."Salary Pointer")
                {
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.';
                    ApplicationArea = All;
                }
                field("Basic Pay int"; Rec."Basic Pay int")
                {
                    Visible = false;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Earnings)
            {
                Caption = 'Earnings';
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = false;
                RunObject = Page "Scale Benefits";
                RunPageLink = "Salary Scale" = FIELD("Salary Scale"), "Salary Pointer" = FIELD("Salary Pointer");
            }
        }
    }
}
