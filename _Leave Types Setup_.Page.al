page 50415 "Leave Types Setup"
{
    PageType = List;
    SourceTable = "Leave Type";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Days; Rec.Days)
                {
                }
                field("Unlimited Days"; Rec."Unlimited Days")
                {
                    Visible = false;
                }
                field(Gender; Rec.Gender)
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {
                }
                field("Annual Leave"; Rec."Annual Leave")
                {
                }
                field("Inclusive of Holidays"; Rec."Inclusive of Holidays")
                {
                }
                field("Inclusive of Saturday"; Rec."Inclusive of Saturday")
                {
                }
                field("Inclusive of Sunday"; Rec."Inclusive of Sunday")
                {
                }
                field("Off/Holidays Days Leave"; Rec."Off/Holidays Days Leave")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    actions
    {
    }
}
