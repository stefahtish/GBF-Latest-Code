page 51320 "Prospective Customer List"
{
    CardPageID = "Prospective Customer card";
    PageType = List;
    SourceTable = "Prospective Customers";
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
                field(ApplicationDate; Rec.ApplicationDate)
                {
                    Caption = 'Registration Date';
                }
                field(Name; Rec.Name)
                {
                }
                field("E-mail"; Rec."E-mail")
                {
                }
            }
        }
    }
    actions
    {
    }
}
