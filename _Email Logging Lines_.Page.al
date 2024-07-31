page 50662 "Email Logging Lines"
{
    PageType = Listpart;
    SourceTable = "Email Logging Liness";
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
                field("Line No"; Rec."Line No")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Sent; Rec.Sent)
                {
                }
                field("Error Message"; Rec."Error Message")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Period; Rec.Period)
                {
                }
                field("Client Code"; Rec."Client Code")
                {
                }
            }
        }
    }
    actions
    {
    }
}
