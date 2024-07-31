page 50170 "Prequalified Supplier"
{
    PageType = Card;
    SourceTable = "Prequalified Suppliers";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Vendor No"; Rec."Vendor No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Physical Address"; Rec."Physical Address")
                {
                }
                field("Postal Address"; Rec."Postal Address")
                {
                }
                field(City; Rec.City)
                {
                }
                field("E-mail"; Rec."E-mail")
                {
                }
                field("Telephone No"; Rec."Telephone No")
                {
                }
                field("Mobile No"; Rec."Mobile No")
                {
                }
                field("Contact Person"; Rec."Contact Person")
                {
                }
                field("KBA Bank Code"; Rec."KBA Bank Code")
                {
                    Visible = false;
                }
                field("KBA Branch Code"; Rec."KBA Branch Code")
                {
                    Visible = false;
                }
                field("Bank account No"; Rec."Bank account No")
                {
                    Visible = false;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                }
                field("Contract Period"; Rec."Contract Period")
                {
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    Enabled = false;
                }
                // field(Category; Category)
                // {
                // }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                }
                field(Selected; Rec.Selected)
                {
                }
                // field("Pre Qualified"; "Pre Qualified")
                // {
                //     Enabled = false;
                // }
                field("Fax No"; Rec."Fax No")
                {
                }
                // field("Category Name"; "Category Name")
                // {
                // }
                field("Registration No"; Rec."Registration No")
                {
                    Caption = 'Registration/Incorporation Number';
                }
                // Group("Hide Compliance")
                // {
                //     ShowCaption = false;
                //     visible = incorporation;
                //     field("Incorporation Number"; Rec."Incorporation Number")
                //     {
                //         ToolTip = 'Specifies the value of the Incorporation Number field.';
                //         ApplicationArea = All;
                //     }
                // }
                field("Company PIN No"; Rec."Company PIN No")
                {
                }
                field(BeneFiciaryGroup; Rec.BeneFiciaryGroup)
                {
                    ToolTip = 'Specifies the value of the BeneFiciaryGroup field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Beneficiary Group';

                    Trigger onValidate()
                    begin
                        //Agpovisible := true;
                        if Rec.BeneFiciaryGroup = Rec.BeneFiciaryGroup::General then begin
                            AgpoVisible := false;
                        end
                        else begin
                            agpovisible := true;
                        end;
                        currpage.Update();
                    end;
                }
                Group("Hide Group")
                {
                    ShowCaption = false;
                    visible = agpovisible;

                    field("AGPO NO."; Rec."AGPO NO.")
                    {
                        ToolTip = 'Specifies the value of the AGPO NO. field.';
                        ApplicationArea = All;
                        ShowMandatory = TRUE;
                    }
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ToolTip = 'Specifies the value of the KRA PIN field.';
                    ApplicationArea = All;
                    ShowMandatory = TRUE;
                }
                field("Tax Compliance"; Rec."Tax Compliance")
                {
                    ToolTip = 'Specifies the value of the Tax Compliance No. field.';
                    ApplicationArea = All;
                }
                field("Name of Director"; Rec."Name of Director")
                {
                    ToolTip = 'Specifies the value of the Name of Director field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                // field(Status; Status)
                // {
                // }
                // field(Attachment; Attachment)
                // {
                // }
            }
            part("Prequalified Supplier Codes"; "Prequalified Supplier Codes")
            {
                SubPageLink = Vendor = field("Vendor No");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Prequalify)
            {
                Caption = 'Create Vendor';
                Image = CreateDocument;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec."Pre Qualified" := true;
                end;
            }
        }
    }
    var
        Agpovisible: boolean;
    //Incorporation: boolean;
    trigger OnOpenPage()
    begin
        Agpovisible := true;
        //incorporation := true;
    end;
}
