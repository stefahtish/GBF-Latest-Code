page 51248 "Expense Code"
{
    PageType = List;
    SourceTable = "Expense Code";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("G/L Account"; Rec."G/L Account")
                {
                }
                field("Expense Type"; Rec."Expense Type")
                {
                }
                field("Per Diem"; Rec."Per Diem")
                {
                }
            }
        }
    }
    actions
    {
    }
}
