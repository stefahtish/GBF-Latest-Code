page 50457 "Travelling Non Employees"
{
    PageType = Listpart;
    SourceTable = "Travelling Non Employees";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                }
                field("Passport No"; Rec."Passport No")
                {
                    Caption = 'ID/ Passport No.';
                }
            }
        }
    }
    actions
    {
    }
}
