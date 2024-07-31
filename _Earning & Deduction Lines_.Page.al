page 50675 "Earning & Deduction Lines"
{
    PageType = ListPart;
    SourceTable = "Import Earn & Ded Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    Visible = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
}
