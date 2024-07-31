page 51131 "License applicant outlets"
{
    Caption = 'Outlets';
    PageType = ListPart;
    CardPageId = "Applicant outlets card";
    SourceTable = "License Applicants Branches";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Outlet; Rec.Outlet)
                {
                    ApplicationArea = All;
                }
                field("Application no"; Rec."Application no")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Areas of sale")
    //         {
    //             Promoted = true;
    //             PromotedOnly = true;
    //             PromotedCategory = Process;
    //             RunObject = page "Applicant Product Area of Sale";
    //             RunPageLink = "Applicant No" = field("Application no"), Outlet = field(Outlet);
    //         }
    //     }
    // }
}
