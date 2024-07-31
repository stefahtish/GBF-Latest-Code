page 50624 "Company Job Prof Membership"
{
    Caption = 'Company Job Professional membership';
    PageType = ListPart;
    SourceTable = "Company Job Prof Membership";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
