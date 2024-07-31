page 50666 "Hotel Bill Lines"
{
    PageType = ListPart;
    SourceTable = "Hotel Bills Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("G/L Account"; Rec."G/L Account")
                {
                }
                field("Bill Type"; Rec."Bill Type")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Bill Description"; Rec."Bill Description")
                {
                }
            }
        }
    }
    actions
    {
    }
}
