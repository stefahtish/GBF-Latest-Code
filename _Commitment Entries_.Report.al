report 50136 "Commitment Entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CommitmentEntries.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Commitment Entries"; "Commitment Entries")
        {
            DataItemTableView = WHERE("Commitment Type" = FILTER(Commitment));
            RequestFilterFields = "Global Dimension 1", "Global Dimension 2", "Document Type", "Commitment Date";

            column(CommitmentNo_CommitmentEntries; "Commitment Entries"."Commitment No")
            {
            }
            column(CommitmentDate_CommitmentEntries; "Commitment Entries"."Commitment Date")
            {
            }
            column(CommitmentType_CommitmentEntries; "Commitment Entries"."Commitment Type")
            {
            }
            column(EntryNo_CommitmentEntries; "Commitment Entries"."Entry No")
            {
            }
            column(DocumentType_CommitmentEntries; "Commitment Entries"."Document Type")
            {
            }
            column(DocumentNo_CommitmentEntries; "Commitment Entries"."Document No")
            {
            }
            column(Account_CommitmentEntries; "Commitment Entries".Account)
            {
            }
            column(User_CommitmentEntries; "Commitment Entries".User)
            {
            }
            column(AccountNo_CommitmentEntries; "Commitment Entries"."Account No.")
            {
            }
            column(AccountName_CommitmentEntries; "Commitment Entries"."Account Name")
            {
            }
            column(Description_CommitmentEntries; "Commitment Entries".Description)
            {
            }
            column(AccountType_CommitmentEntries; "Commitment Entries"."Account Type")
            {
            }
            column(UncommittmentDate_CommitmentEntries; "Commitment Entries"."Uncommittment Date")
            {
            }
            column(CommittedAmount_CommitmentEntries; "Commitment Entries"."Committed Amount")
            {
            }
            column(InvoiceNo_CommitmentEntries; "Commitment Entries".InvoiceNo)
            {
            }
            column(No_CommitmentEntries; "Commitment Entries".No)
            {
            }
            column(NoSeries_CommitmentEntries; "Commitment Entries"."No. Series")
            {
            }
            column(GlobalDimension1_CommitmentEntries; "Commitment Entries"."Global Dimension 1")
            {
            }
            column(GlobalDimension2_CommitmentEntries; "Commitment Entries"."Global Dimension 2")
            {
            }
            column(LineNo_CommitmentEntries; "Commitment Entries"."Line No.")
            {
            }
            column(DimensionSetID_CommitmentEntries; "Commitment Entries"."Dimension Set ID")
            {
            }
            column(LastModifiedBy_CommitmentEntries; "Commitment Entries"."Last Modified By")
            {
            }
            column(GlobalDimension3_CommitmentEntries; "Commitment Entries"."Global Dimension 3")
            {
            }
            column(GlobalDimension4_CommitmentEntries; "Commitment Entries"."Global Dimension 4")
            {
            }
            column(GlobalDimension5_CommitmentEntries; "Commitment Entries"."Global Dimension 5")
            {
            }
            column(GlobalDimension6_CommitmentEntries; "Commitment Entries"."Global Dimension 6")
            {
            }
            column(GlobalDimension7_CommitmentEntries; "Commitment Entries"."Global Dimension 7")
            {
            }
            column(GlobalDimension8_CommitmentEntries; "Commitment Entries"."Global Dimension 8")
            {
            }
            column(Name_CompanyInformation; CompanyInformation.Name)
            {
            }
            column(AddressCompanyInformation; CompanyInformation.Address)
            {
            }
            column(CityCompanyInformation; CompanyInformation.City)
            {
            }
            column(Phone_No_CompanyInformation; CompanyInformation."Phone No.")
            {
            }
            column(Fax_No_CompanyInformation; CompanyInformation."Fax No.")
            {
            }
            column(Picture_CompanyInformation; CompanyInformation.Picture)
            {
            }
            column(E_Mail_CompanyInformation; CompanyInformation."E-Mail")
            {
            }
            column(Home_Page_CompanyInformation; CompanyInformation."Home Page")
            {
            }
            column(FilteredAccountNo; FilteredAccountNo)
            {
            }
            trigger OnPreDataItem()
            begin
                "Commitment Entries".SetRange("Commitment Entries".Account, FilteredAccountNo);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Control2)
                {
                    ShowCaption = false;

                    field("""Commitment Entries"".Account"; "Commitment Entries".Account)
                    {
                        Caption = 'Vote No. (Account No)';
                        TableRelation = "G/L Account"."No.";
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
        FilteredAccountNo := "Commitment Entries".Account;
    end;

    var
        CompanyInformation: Record "Company Information";
        FilteredAccountNo: Code[20];
}
