page 50691 "Imprest Deduction Line"
{
    PageType = ListPart;
    SourceTable = "Imprest Deduction Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Imprest No"; Rec."Imprest No")
                {
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
